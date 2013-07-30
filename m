From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-msm: Add support for MSM chipsets
Date: Tue, 30 Jul 2013 17:40:16 +0100
Message-ID: <86y58orogf.fsf@void.printf.net>
References: <1375201355-26906-1-git-send-email-gdjakov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1375201355-26906-1-git-send-email-gdjakov@mm-sol.com> (Georgi
	Djakov's message of "Tue, 30 Jul 2013 19:22:35 +0300")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Georgi Djakov <gdjakov@mm-sol.com>
Cc: linux-mmc@vger.kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Asutosh Das <asutoshd@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi Georgi,

On Tue, Jul 30 2013, Georgi Djakov wrote:
> This platform driver adds the support of Secure Digital Host
> Controller Interface compliant controller in MSM chipsets.
>
> CC: Asutosh Das <asutoshd@codeaurora.org>
> CC: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> CC: Sahitya Tummala <stummala@codeaurora.org>
> CC: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
> ---
> This is an initial version of the Qualcomm MSM SDHCI driver.
> It is based on the SDHCI code from coreaurora.org with minor
> modifications. The MMC standard DT bindings are used where
> possible. The patch applies to v3.11-rc3.

Is the arch code that will use this driver already in mainline,
or on its way in?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
