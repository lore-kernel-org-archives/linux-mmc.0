From: Chris Ball <cjb@laptop.org>
Subject: Re: [RESEND PATCH] mmc: dw_mmc: Add check for IDMAC configuration
Date: Wed, 20 Jun 2012 02:07:28 -0400
Message-ID: <87wr324iu7.fsf@octavius.laptop.org>
References: <1339495102-4889-1-git-send-email-girish.shivananjappa@linaro.org>
	<CAFbHwiRXXbOzCPeb0jdrzjmq1aeisjRSY5xNwrQbeNYJx04UJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41800 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267Ab2FTGHd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jun 2012 02:07:33 -0400
In-Reply-To: <CAFbHwiRXXbOzCPeb0jdrzjmq1aeisjRSY5xNwrQbeNYJx04UJg@mail.gmail.com>
	(Will Newton's message of "Tue, 12 Jun 2012 11:08:02 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Girish K S <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org, patches@linaro.org

Hi Girish,

On Tue, Jun 12 2012, Will Newton wrote:
> On Tue, Jun 12, 2012 at 10:58 AM, Girish K S
> <girish.shivananjappa@linaro.org> wrote:
>> In the Current dwmmc driver there is support for selecting IDMAC fro=
m
>> the menu config option. If the support for IDMAC is enabled in the m=
enu
>> config and Hardware configuration register's DMA_INTERFACE field is =
0.
>> Still the driver will try to do the DMA initialization.
>>
>> The dw_mci_idmac_init function currently implemented returns only su=
ccess
>> indicating that the DMA initialization is always successful. The cur=
rent
>> patch will add a ciheck for existance of the DMA IP and allow the
>> DMA initialization.
>>
>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>> ---
>> =C2=A0drivers/mmc/host/dw_mmc.c | =C2=A0 15 +++++++++++++--
>> =C2=A01 files changed, 13 insertions(+), 2 deletions(-)
>
> Ok, this version looks better.
>
> Acked-by: Will Newton <will.newton@imgtec.com>

A quick point of patch etiquette:  you used a subject line of [RESEND
PATCH], but this isn't a resend of a patch.  A resend is when you're
resending a copy of a patch *without any modifications* because it was
ignored, or you'd like more discussion, or you're adding new people to
the e-mail thread.

This is a v2 of a patch, because you made changes since the last patch.
The right way to signify that is with [PATCH v2] in the Subject line,
and a section just below the "---" after the Signed-off-by that explain=
s
what you changed.  E.g.:

=3D=3D=3D=3D=3D=3D=3D
Subject: [PATCH v2] mmc: dw_mmc: Add check for IDMAC configuration

In the Current dwmmc driver there is support for selecting IDMAC from
the menu config option. If the support for IDMAC is enabled in the menu
config and Hardware configuration register's DMA_INTERFACE field is 0.
Still the driver will try to do the DMA initialization.

The dw_mci_idmac_init function currently implemented returns only succe=
ss
indicating that the DMA initialization is always successful. The curren=
t
patch will add a ciheck for existance of the DMA IP and allow the
DMA initialization.

Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
Changes since v1:
 * Protect against configuration mistakes by falling back to PIO if
   CONFIG_MMC_DW_IDMAC=3Dy but the hardware has no IDMAC support.
=20
 drivers/mmc/host/dw_mmc.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
=3D=3D=3D=3D=3D=3D=3D

I've applied the patch to mmc-next for 3.6 now.

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
