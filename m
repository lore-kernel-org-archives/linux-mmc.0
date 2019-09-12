From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [RFC 1/2] mmc: sdhci-msm: Add support for bus bandwidth voting
Date: Thu, 12 Sep 2019 15:56:08 +0300
Message-ID: <616c7a8c-a1cf-2043-4ea4-f452ee90f083@linaro.org>
References: <1567774037-2344-1-git-send-email-ppvk@codeaurora.org>
 <1567774037-2344-2-git-send-email-ppvk@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567774037-2344-2-git-send-email-ppvk@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pradeep P V K <ppvk@codeaurora.org>, adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc: asutoshd@codeaurora.org, vbadigan@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, rampraka@codeaurora.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, Subhash Jadavani <subhashj@codeaurora.org>, Andy Gross <agross@kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Pradeep,

Thanks for the patch!

On 9/6/19 15:47, Pradeep P V K wrote:
> Vote for the MSM bus bandwidth required by SDHC driver
> based on the clock frequency and bus width of the card.
> Otherwise,the system clocks may run at minimum clock speed
> and thus affecting the performance.
> 
> This change is based on Georgi Djakov [RFC]
> (https://lkml.org/lkml/2018/10/11/499)

I am just wondering whether do we really need to predefine the bandwidth values
in DT? Can't we use the computations from the above patch or is there any
problem with that approach?

Thanks,
Georgi
