From: Georgi Djakov <gdjakov@mm-sol.com>
Subject: Re: [PATCH RFC v3] mmc: sdhci-msm: Add support for MSM chipsets
Date: Thu, 05 Sep 2013 18:57:46 +0300
Message-ID: <5228A9FA.90003@mm-sol.com>
References: <1377017077-9834-1-git-send-email-gdjakov@mm-sol.com> <521C699A.2010609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([212.124.72.66]:49880 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612Ab3IEP4k (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Sep 2013 11:56:40 -0400
In-Reply-To: <521C699A.2010609@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, grant.likely@linaro.org, rob.herring@calxeda.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, Asutosh Das <asutoshd@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>

Hi Jaehoon,

On 08/27/2013 11:55 AM, Jaehoon Chung wrote:
> Hi Georgi,
>
> I found the sdhci_msm_vreg_reset(). Why do you run enable->disable?
>
> +/*
> + * Reset vreg by ensuring it is off during probe. A call
> + * to enable vreg is needed to balance disable vreg
> + */
> +static int sdhci_msm_vreg_reset(struct sdhci_msm_pltfm_data *pdata)
>
> I think that controller didn't have responsibility to ensure whether power is enabled or not at probing time.
> If just needed to balance vreg, then i think this function can be removed.
> How about?
>
> Also before using regulator_is_enabled(), i had found the hole for balancing the vreg.

Thank you! I'll remove this function.

BR,
Georgi

