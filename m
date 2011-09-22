From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH v3 1/1] mmc: Support of DUAL BUFFER DESC[ring] mode for dw_mmc
Date: Thu, 22 Sep 2011 09:18:18 +0530
Message-ID: <CANYdXnrmfaUikePiYPw1w41PY2OAmCwj5_a3Q1cGuJfk6pCaJw@mail.gmail.com>
References: <1314704721-5175-1-git-send-email-shashidharh@vayavyalabs.com>
	<m2boud3fg3.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44611 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab1IVDsp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Sep 2011 23:48:45 -0400
Received: by iaqq3 with SMTP id q3so2374334iaq.19
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2011 20:48:45 -0700 (PDT)
In-Reply-To: <m2boud3fg3.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, will.newton@gmail.com, linux-mmc@vger.kernel.org

Hi Chris ,
  I have tested this patch with some modifications.I will soon submit
another patch with the modifications.

On Thu, Sep 22, 2011 at 12:12 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Tue, Aug 30 2011, Shashidhar Hiremath wrote:
>> This Patch adds the support for Dual Buffer Descriptor mode of
>> Operation for the dw_mmc driver.The patch also provides the configur=
ability
>> Option for choosing DUAL_BUFFER mode or the chained modes through me=
nuconfig.
>> The Menuconfig option for selecting Dual Buffer mode or chained mode
>> is selected only if Internal DMAC is enabled.
>>
>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>
> I'm reluctant to merge an untested patch, so I'm inclined to wait unt=
il
> someone says they're seeing a quantified performance gain with this a=
nd
> want it to be merged.
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =C2=A0 <cjb@laptop.org> =C2=A0 <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
regards,
Shashidhar Hiremath
