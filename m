From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v6 9/9] mmc: dw_mmc: add support for exynos specific
 implementation of dw-mshc
Date: Fri, 21 Sep 2012 11:27:11 +0900
Message-ID: <003601cd97a0$9af71ce0$d0e556a0$%jun@samsung.com>
References: <1347905803-22742-1-git-send-email-thomas.abraham@linaro.org>
 <1347905803-22742-10-git-send-email-thomas.abraham@linaro.org>
 <001501cd966c$ab1ef6e0$015ce4a0$%jun@samsung.com>
 <CAJuYYwQpjhA0O7bg7AVGOvi2Np9kEdbv4xqjFDB4p_XTDD+CjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:28573 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932627Ab2IUC1N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Sep 2012 22:27:13 -0400
In-reply-to: <CAJuYYwQpjhA0O7bg7AVGOvi2Np9kEdbv4xqjFDB4p_XTDD+CjA@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Thomas Abraham' <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, patches@linaro.org, 'Thomas Abraham' <thomas.ab@samsung.com>

On Thursday, September 20, 2012, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> On 19 September 2012 19:12, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > On Tuesday, September 18, 2012, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> >> +int dw_mci_exynos_probe(struct platform_device *pdev)
> >> +{
> >> +     struct dw_mci_drv_data *drv_data;
> >> +     const struct of_device_id *match;
> >> +
> >> +     match = of_match_node(dw_mci_exynos_match, pdev->dev.of_node);
> >> +     drv_data = match->data;
> > In non-dt case, match has NULL.
> > Needed to check "pdev->dev.of_node"
> 
> Since all current users in mainline of this driver on Exynos platforms
> are device tree based, and since Exynos4 and Exynos5 have device tree
> support, I have mainly been adding device tree support here. Only for
> non-exynos portions of the code, I have ensured that both dt and
> legacy modes are supported.
Yes. I know, then dw_mmc-exynos.c should have a dependency of CONFIG_OF?
It needs to prevent kernel panic at least.

Thanks,
Seungwon Jeon
Thanks,
Seungwon Jeon
> 
> Thanks,
> Thomas.
> 
> [...]
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

