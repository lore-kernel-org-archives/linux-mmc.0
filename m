From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] atmel-mci and maybe android-goldfish broken on 4.18
Date: Tue, 21 Aug 2018 16:19:11 +0200
Message-ID: <CAPDyKFpgRXDpQQKBGC-MieTMnG-v1wcjzAB9Jg3xhFjsdwXOYg@mail.gmail.com>
References: <20180820085445.14632-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820085445.14632-1-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, dgilbert@interlog.com
List-Id: linux-mmc@vger.kernel.org

On 20 August 2018 at 10:54, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
> Hi,
>
> Dougas Gilbert noticed that atmel-mci was broken with the 4.18 release.
> He found the culprit commit which is 5b4277814e3fd
> ("[PATCH 2/7] mmc: atmel-mci: use sg_copy_{from,to}_buffer"). The from/to
> logic was inverted: sg_copy_to_buffer copies from an SG list to a linear
> buffer so it can't replace a memcpy where the destination is the virtual
> address of an SG buffer.
>
> This patch was part of "make more host drivers highmem safe v2". It seems
> there is the same logical error within the android-goldfish driver but I
> couldn't check it on real hardware.
>
> Ludovic Desroches (2):
>   mmc: atmel-mci: fix bad logic of sg_copy_{from,to}_buffer conversion
>   mmc: android-goldfish: fix bad logic of sg_copy_{from,to}_buffer
>     conversion
>
>  drivers/mmc/host/android-goldfish.c |  4 ++--
>  drivers/mmc/host/atmel-mci.c        | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>

Thanks, applied for fixes!

Kind regards
Uffe
