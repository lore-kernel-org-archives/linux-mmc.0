From: Asutosh Das <asutoshd@codeaurora.org>
Subject: Re: [PATCH v1 1/1] mmc: host: add SDHCI platform driver for msm chipsets
Date: Tue, 29 Jan 2013 09:30:01 +0530
Message-ID: <51074941.9030603@codeaurora.org>
References: <1357712243-486-1-git-send-email-asutoshd@codeaurora.org> <87obg981di.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:28606 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640Ab3A2EAO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Jan 2013 23:00:14 -0500
In-Reply-To: <87obg981di.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Venkat Gopalakrishnan <venkatg@codeaurora.org>

On 1/29/2013 2:35 AM, Chris Ball wrote:
> Hi Asutosh,
>
> On Wed, Jan 09 2013, Asutosh Das wrote:
>> This platform driver adds the support of Secure Digital Host
>> Controller Interface compliant controller in MSM chipsets.
>>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Please resubmit (or just let me know) this patch once the SoC that
> contains this IP has mainline support queued for merging.
>
> Also, please switch to using the standard MMC DT bindings where possible
> instead of the qcom,-prefixed ones.
>
> Thanks!
>
> - Chris.
Hi Chris
sure will do.

Thanks
Asutosh

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

