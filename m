From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH v2 08/10] ARM: STi: DT: Enable second sdhci controller
 for stih416 b2020 boards.
Date: Wed, 9 Jul 2014 13:00:20 +0200
Message-ID: <53BD20C4.2070500@st.com>
References: <1401898054-686-1-git-send-email-peter.griffin@linaro.org> <1401898054-686-9-git-send-email-peter.griffin@linaro.org> <CAPDyKFor1LqgAcJZc14iSY6D8RYm4w7sysRR3c2inSr4LVYt8w@mail.gmail.com> <20140709103016.GA5042@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33605 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751183AbaGILA2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jul 2014 07:00:28 -0400
In-Reply-To: <20140709103016.GA5042@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Patrice CHOTARD <patrice.chotard@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Ulf, Peter,

	I will queue the DT patches to my pull request for v3.17.

	Peter, I will need it to be rebased anyway.

Thanks,
Maxime

On 07/09/2014 12:30 PM, Peter Griffin wrote:
> Hi Ulf,
>
> Many thanks for looking at this.
>
>>> +
>>> +               mmc1: sdhci@fe81f000 {
>>> +                       status       = "okay";
>>> +                       bus-width    = <8>;
>>> +                       non-removable;
>>> +               };
>>>          };
>>
>> Hi Peter,
>>
>> I was trying to apply this patchset on my next branch, but the above
>> file /arch/arm/boot/dts/stih416-b2020-revE.dts does not exist. And I
>> don't see it in linux-next either.
>>
>> What tree/patch are this based upon?
>
> The patchset was on top of v3.15-rc1, however since then that file got renamed
> to stih416-b2020e.dts, which went into 3.16 fixes.
>
> See here for more details https://lkml.org/lkml/2014/6/18/241
>
> Would you like me to re-send or can you up fixup?
>
> regards,
>
> Peter.
>
