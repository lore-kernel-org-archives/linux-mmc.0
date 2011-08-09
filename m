From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH --mmotm v5 1/3] fault-inject: export fault injection functions
Date: Tue, 9 Aug 2011 10:44:31 +0200
Message-ID: <CAJ0pr18bsmoRUAs59zsTtW8Qn7qn=mBbsx3iXnmFEwomHM-JPA@mail.gmail.com>
References: <1312834049-29910-1-git-send-email-per.forlin@linaro.org>
	<1312834049-29910-2-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1312834049-29910-2-git-send-email-per.forlin@linaro.org>
Sender: owner-linux-mm@kvack.org
To: Akinobu Mita <akinobu.mita@gmail.com>, akpm@linux-foundation.org, Linus Walleij <linus.ml.walleij@gmail.com>, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linaro-dev@lists.linaro.org, linux-mm@kvack.org, Per Forlin <per.forlin@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 8 August 2011 22:07, Per Forlin <per.forlin@linaro.org> wrote:
> export symbols fault_should_fail() and fault_create_debugfs_attr() in order
> to let modules utilize the fault injection
This patch is already merged in mainline too.
Unfortunately I left a typo here. It says fault_should_fail() in the
commit message but the function in the patch is called only
should_fail(). This is already in rc1 so I guess we have to live with
this typo.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
