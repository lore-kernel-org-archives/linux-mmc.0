From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 0/3] mmc: rectify boot param option for fault injection
Date: Wed, 21 Sep 2011 14:57:58 -0400
Message-ID: <m2mxdx205k.fsf@bob.laptop.org>
References: <1316002218-3408-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316002218-3408-1-git-send-email-per.forlin@linaro.org> (Per
	Forlin's message of "Wed, 14 Sep 2011 14:10:15 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linaro-dev@lists.linaro.org, Akinobu Mita <akinobu.mita@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Per,

On Wed, Sep 14 2011, Per Forlin wrote:
> Akinobu Mita reported that the boot option for mmc fault injection is never
> compiled in due to a fauly "ifdef KERNEL" that is never set.
> A correct ifdef would be "ifndef MODULE". This patch set adds a
> module_param_cb() and thereby no ifndef MODULE is needed.
> Using a module_param makes it possible to pass default fault attributes for
> external modules too.

Thanks, all merged to mmc-next for 3.2 with Akinobu-san's Reviewed-by.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
