From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Add check for IDMAC configuration
Date: Tue, 12 Jun 2012 10:44:48 +0100
Message-ID: <CAFbHwiTxtZ8RUcMB9oPvBYZuqOsd=w0JFGcQAYE+OTZPXVQHaA@mail.gmail.com>
References: <1339474866-17805-1-git-send-email-girish.shivananjappa@linaro.org>
	<CAFbHwiQGGAKaoX3Pco_XgeyyX4oDmrmDGLH=_fkdaxv73J9Kgw@mail.gmail.com>
	<CAGxe1ZF5hrrbxJ6K6s7Wo-=0gQXt2NT7vJRypdWb5LPcD_jgdw@mail.gmail.com>
	<CAFbHwiQ5Y9wRY=cdO_DeHKMumFgX+eqxKj8vfBXsesZYG=M=-A@mail.gmail.com>
	<CAGxe1ZFhcq3DSDnqujcHJwM3FVxggpPD8q6unDbwkP+EDeDbbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37055 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab2FLJot convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 05:44:49 -0400
Received: by dady13 with SMTP id y13so6631844dad.19
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jun 2012 02:44:48 -0700 (PDT)
In-Reply-To: <CAGxe1ZFhcq3DSDnqujcHJwM3FVxggpPD8q6unDbwkP+EDeDbbg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org

On Tue, Jun 12, 2012 at 10:40 AM, Girish K S
<girish.shivananjappa@linaro.org> wrote:
> On 12 June 2012 15:05, Will Newton <will.newton@gmail.com> wrote:
>> On Tue, Jun 12, 2012 at 10:01 AM, Girish K S
>> <girish.shivananjappa@linaro.org> wrote:
>>> On 12 June 2012 14:25, Will Newton <will.newton@gmail.com> wrote:
>>>> On Tue, Jun 12, 2012 at 5:21 AM, Girish K S
>>>> <girish.shivananjappa@linaro.org> wrote:
>>>>>
>>>>> In the Current dwmmc driver there is support for selecting IDMAC =
from
>>>>> the menu config option. If the support for IDMAC is enabled in th=
e menu
>>>>> config and Hardware configuration register's DMA_INTERFACE field =
is 0.
>>>>> Still the driver will try to do the DMA initialization.
>>>>>
>>>>> The dw_mci_idmac_init function currently implemented returns only=
 success
>>>>> indicating that the DMA initialization is always successful. The =
current
>>>>> patch will add a ciheck for existance of the DMA IP and allow the
>>>>> DMA initialization.
>>>>>
>>>>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>>>>> ---
>>>>> =A0drivers/mmc/host/dw_mmc.c | =A0 11 ++++++++++-
>>>>> =A01 files changed, 10 insertions(+), 1 deletions(-)
>>>>
>>>> This looks ok in principle. I'm wondering if we should only allow
>>>> dma_support =3D=3D 0x01 (DW_DMA) in the IDMAC case? It's not clear=
 from
>>>> the TRM what each of the DMA values means and I only have a system
>>>> with external DMA support at the moment.
>>> My understanding from the TRM
>>> if dma_support =3D1; then use designware dma ip for internal
>>> dma_support =3D2 then use any generic dma ip for internal dma tx
>>> this config is only for IDMA support. If there is a external DMA CT=
RL
>>> register should be used explicitly to enable DMA (there is no confi=
g
>>> available to tell external dma supported). correct me if i am wrong=
=2E
>>
>> That sounds like a reasonable interpretation of the TRM. ;-)
>>
>> Acked-by: Will Newton <will.newton@imgtec.com>
> I will resend the patch with minor change so that kernel doesnt crash
> but use PIO mode and continue even if IDMAC is enabled accidentally.
> what s your say?

Yes, let's make sure it is robust against errors in configuration.
