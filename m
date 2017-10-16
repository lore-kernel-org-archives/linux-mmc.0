From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: mainline 4.14-rc4: renesas_sdhi_internal_dmac ee100000.sd:
 swiotlb buffer is full?
Date: Mon, 16 Oct 2017 13:41:39 +0200
Message-ID: <CACRpkdZbdhAbFUa9Dh9j8WtY7iYNhB27Ar4XzTZLrTz=gPPsvQ@mail.gmail.com>
References: <50d1a9ac-fe5f-d0a1-62bc-ff3e252e99da@de.bosch.com>
 <CAMuHMdXPYyi_pXcdtNJkT737dSXnwG88vqETN0Kbe-3AAJ0zOg@mail.gmail.com>
 <f7596566-2f98-d4a1-612c-77caa51b892e@de.bosch.com> <CAMuHMdXEXwwdNPmoFa+peivR_8Bv06r39bg1pAsL7498xrod6A@mail.gmail.com>
 <5ccf4c75-6dd5-0818-54de-2a99a786a5c4@de.bosch.com> <aecf1ec0-7172-ec41-1759-be261f3e0dd2@de.bosch.com>
 <TY1PR06MB0992FAD2C2CD90FFF71E1807D84F0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAMuHMdV=3_9af-aTGnWBLemg3Hrh-D4im1Vxk0mTXstiz0vVUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdV=3_9af-aTGnWBLemg3Hrh-D4im1Vxk0mTXstiz0vVUA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, "REE dirk.behme@de.bosch.com" <dirk.behme@de.bosch.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 16, 2017 at 11:02 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

>> IIUC,
>> - Since the MMC_BOUNCE disappeared in v4.14-rc1, the MMC core will request a command with 64kbyte+ size.
>>  - So, swiotlb will got request 64kbyte+ size. This is different with previous version.

Other people reported problems with that. Sorry about this...

This problem should be solved by upstream
commit de3ee99b097dd51938276e3af388cd4ad0f2750a
"mmc: Delete bounce buffer handling"

I just killed off the bounce buffers so they can't hurt anyone anymore.

Can you check that you have this patch in your tree?

Yours,
Linus Walleij
