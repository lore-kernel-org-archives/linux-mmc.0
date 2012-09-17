From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 3/4] drivers/mmc/host/omap_hsmmc.c: fix error return code
Date: Mon, 17 Sep 2012 23:41:17 +0530
Message-ID: <CANfBPZ8O7Vd5aPZqwDNfwEzgOt0-usPxHg4W1y_v0yS+gTz+pQ@mail.gmail.com>
References: <1347869728-2696-1-git-send-email-peter.senna@gmail.com> <1347869728-2696-3-git-send-email-peter.senna@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347869728-2696-3-git-send-email-peter.senna@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Senna Tschudin <peter.senna@gmail.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Sep 17, 2012 at 1:45 PM, Peter Senna Tschudin
<peter.senna@gmail.com> wrote:
> From: Peter Senna Tschudin <peter.senna@gmail.com>
>
> Convert a nonnegative error return code to a negative one, as returned
> elsewhere in the function.
>
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
>
> // <smpl>
> (
> if@p1 (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret@p1 = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> // </smpl>
>
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>

Looks good.
Acked-by: Venkatraman S <svenkatr@ti.com>
