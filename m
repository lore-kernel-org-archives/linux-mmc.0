From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/2] mmc: dw_mmc: Make dw_mci_exynos_probe static
Date: Mon, 18 Feb 2013 19:51:50 +0900
Message-ID: <001501ce0dc5$f470bab0$dd523010$%jun@samsung.com>
References: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
 <5121F74E.5050903@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:60836 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab3BRKvv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Feb 2013 05:51:51 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MIE00IUGWTWOLF0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 18 Feb 2013 19:51:50 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MIE0019PWUEUJ70@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 18 Feb 2013 19:51:50 +0900 (KST)
In-reply-to: <5121F74E.5050903@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org

Hi Sachin,

You're right.
'dw_mci_exynos_probe' is only used here.

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

On Monday, February 18, 2013, Jaehoon Chung wrote:
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> On 02/18/2013 05:53 PM, Sachin Kamat wrote:
> > Silences the following sparse warning:
> > drivers/mmc/host/dw_mmc-exynos.c:218:5: warning:
> > symbol 'dw_mci_exynos_probe' was not declared. Should it be static?
> >
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > ---
> >  drivers/mmc/host/dw_mmc-exynos.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> > index 72fd0f2..5a09c77 100644
> > --- a/drivers/mmc/host/dw_mmc-exynos.c
> > +++ b/drivers/mmc/host/dw_mmc-exynos.c
> > @@ -215,7 +215,7 @@ static const struct of_device_id dw_mci_exynos_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
> >
> > -int dw_mci_exynos_probe(struct platform_device *pdev)
> > +static int dw_mci_exynos_probe(struct platform_device *pdev)
> >  {
> >  	const struct dw_mci_drv_data *drv_data;
> >  	const struct of_device_id *match;
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

