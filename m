From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH v2 8/8] ARM: STi: DT: STiH407: Add dt nodes for sdhci
 and emmc.
Date: Mon, 30 Mar 2015 13:43:58 +0200
Message-ID: <551936FE.6020604@st.com>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org> <1424956227-18258-9-git-send-email-peter.griffin@linaro.org> <54F594F8.50306@st.com> <20150330112357.GE21893@griffinp-ThinkPad-X1-Carbon-2nd> <20150330113751.GE9447@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34991 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751659AbbC3Loq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2015 07:44:46 -0400
In-Reply-To: <20150330113751.GE9447@x1>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com



On 03/30/2015 01:37 PM, Lee Jones wrote:
> On Mon, 30 Mar 2015, Peter Griffin wrote:
>
>> Hi Maxime,
>>
>> On Tue, 03 Mar 2015, Maxime Coquelin wrote:
>>
>>> On 02/26/2015 02:10 PM, Peter Griffin wrote:
>>>> The nodes have been split to allow as much commonality as possible.
>>>> The stih407 has a silicon bug with eMMC UHS modes (with top regs)
>>>> and as such doesn't have any of the uhs dt properties.
>>>>
>>>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>>>> ---
>>>>   arch/arm/boot/dts/stih407-family.dtsi | 30 ++++++++++++++++++++++++++++++
>>>>   arch/arm/boot/dts/stih410-b2120.dts   | 10 ++++++++++
>>>>   arch/arm/boot/dts/stihxxx-b2120.dtsi  |  8 ++++++++
>>>>   3 files changed, 48 insertions(+)
>>>>
>>>>
>>> Maybe you could also add SD/eMMC support to the b2199 too?
>> Yes ok, I will add support for stih418-b2199 in v3.
> Is there any reason why this can't be actioned in a subsequent patch?
>
It could. But since the series needs a v3, it makes sense to do the 
change now.
