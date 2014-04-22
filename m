From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH RFC 00/12] Add Qualcomm SD Card Controller support.
Date: Tue, 22 Apr 2014 15:16:17 +0100
Message-ID: <535679B1.5080407@linaro.org>
References: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org> <53566778.5090603@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53566778.5090603@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Covington <cov@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, agross@quicinc.com, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Christopher,


On 22/04/14 13:58, Christopher Covington wrote:
> Hi Srini,
>
> On 04/21/2014 05:43 PM, srinivas.kandagatla@linaro.org wrote:
>
>> This patches are tested in PIO mode on IFC8064 board with both eMMC and
>> external SD card. I would appreciate any feedback/suggestions on the overall
>> approach.
>
I pushed a temporary tag "mmci-pio-srini-wip" for you on my git tree 
git://git.linaro.org/landing-teams/working/qualcomm/kernel.git

> Is a non-upstream device tree needed to reproduce your test setup? If so could
> you please point to or post it?

You will need to use multi_v7_defconfig.

Thanks,
srini
>
> Thanks,
> Christopher
>
