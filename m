From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2 1/4] drivers/mmc/host/dw_mmc.c: fix error return code
Date: Tue, 18 Sep 2012 19:13:47 +0900
Message-ID: <018101cd9586$4ac78b40$e056a1c0$%jun@samsung.com>
References: <1347869728-2696-1-git-send-email-peter.senna@gmail.com>
 <1347884417-26754-1-git-send-email-peter.senna@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1347884417-26754-1-git-send-email-peter.senna@gmail.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Peter Senna Tschudin' <peter.senna@gmail.com>, cjb@laptop.org
Cc: will.newton@imgtec.com, jh80.chung@samsung.com, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Monday, September 17, 2012, Peter Senna Tschudin <peter.senna@gmail.com> wrote:
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
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

> --
> 1.7.11.4
