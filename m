From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 2/3] mmc: core: add random fault injection
Date: Fri, 19 Aug 2011 16:16:42 +0200
Message-ID: <CAKnu2Mq9N0JyrBnfJ2GupgEcKUfsGUkxZvRcBq9d2s07xUZyDA@mail.gmail.com>
References: <1313758358-27536-1-git-send-email-per.forlin@stericsson.com>
	<1313758358-27536-2-git-send-email-per.forlin@stericsson.com>
	<1313758358-27536-3-git-send-email-per.forlin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1313758358-27536-3-git-send-email-per.forlin-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Per Forlin <per.forlin-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

2011/8/19 Per Forlin <per.forlin-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>:

> From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> This adds support to inject data errors after a completed host transfer.
> The mmc core will return error even though the host transfer is successful.
> This simple fault injection proved to be very useful to test the
> non-blocking error handling in the mmc_blk_issue_rw_rq().
> Random faults can also test how the host driver handles pre_req()
> and post_req() in case of errors.
>
> Signed-off-by: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

OK!

Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
For the MMC portions in 2/3.

Linus Walleij
