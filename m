From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH 5/6] mmc: sdhci-st: Do cleanup while mmc_of_parse() return
 an error
Date: Thu, 18 Dec 2014 10:44:58 +0100
Message-ID: <5492A21A.4060604@st.com>
References: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org> <1418895704-25908-6-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51634 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751876AbaLRJpO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 04:45:14 -0500
In-Reply-To: <1418895704-25908-6-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Patrice Chotard <patrice.chotard@st.com>

Hi Ulf,

On 12/18/2014 10:41 AM, Ulf Hansson wrote:
> At errors, balance sdhci_pltfm_init() with sdhci_pltfm_free(), to make
> sure all data is freed properly.
>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/mmc/host/sdhci-st.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
>

You can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
