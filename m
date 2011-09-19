From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v3 0/3] mmc: rectify boot param option for fault injection
Date: Mon, 19 Sep 2011 12:51:54 +0900
Message-ID: <CAC5umyiTrU-6VoaMnsFFqyW7_bJToViOdWbwC04PM9LUSxQkRw@mail.gmail.com>
References: <1316002218-3408-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1316002218-3408-1-git-send-email-per.forlin@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linaro-dev@lists.linaro.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

2011/9/14 Per Forlin <per.forlin@linaro.org>:
> Akinobu Mita reported that the boot option for mmc fault injection is never
> compiled in due to a fauly "ifdef KERNEL" that is never set.
> A correct ifdef would be "ifndef MODULE". This patch set adds a
> module_param_cb() and thereby no ifndef MODULE is needed.
> Using a module_param makes it possible to pass default fault attributes for
> external modules too.

All patches look good to me.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
