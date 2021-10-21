document.addEventListener("DOMContentLoaded", function() {
    load_navpane();
});

function load_navpane() {
    var width = window.innerWidth;
    if (width <= 1200) {
        return;
    }

    var nav = document.getElementsByClassName("md-nav");
    for(var i = 0; i < nav.length; i++) {
        if (typeof nav.item(i).style === "undefined") {
            continue;
        }

        if (nav.item(i).getAttribute("data-md-level") && nav.item(i).getAttribute("data-md-component")) {
            nav.item(i).style.display = 'block';
            nav.item(i).style.overflow = 'visible';
        }
    }

    var nav = document.getElementsByClassName("md-nav__toggle");
    for(var i = 0; i < nav.length; i++) {
       nav.item(i).checked = true;
    }
}
window.addEventListener('click', function (event) {
    setTimeout(() => {
        if (event.target.className === 'md-nav__link') {
            document.querySelectorAll('pre code').forEach((block) => {
                hljs.highlightBlock(block);
            });
        }
    }, 200);
    //fallback if page do not rendered in 200ms
    setTimeout(() => {
        if (event.target.className === 'md-nav__link') {
            document.querySelectorAll('pre code').forEach((block) => {
                hljs.highlightBlock(block);
            });
        }
    }, 200);
});

hljs.initHighlightingOnLoad();

document.addEventListener("DOMContentLoaded", function(event) {
    if (document.querySelector('#was-it-helpful')) {
        new WasItHelpful('#was-it-helpful', {
            labels: {
                "question_text": "Was this article helpful?",
                "answer_yes": "Yes!",
                "answer_no": "No.",
                "sorry_text": "Sorry about that! How can we improve it?",
                "submit_btn": "Send feedback",
                "thank_you": "Thanks!"
            },
            onSubmit: function(data) {
                var xhr = new XMLHttpRequest();
                xhr.open("POST", 'https://api.flotiq.com/api/v1/content/doc_helpful_articles_info', true);
                xhr.setRequestHeader('Content-Type', 'application/json');
                xhr.setRequestHeader('X-AUTH-TOKEN', '67435b482ad3a3bf2ad1667add0745c4');
                xhr.send(JSON.stringify({
                    'subject': document.getElementsByTagName("title")[0].innerHTML,
                    'url': window.location.href,
                    'helpful': data.helpful,
                    'message': data.message
                }));
            }});
    }
});
