From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc should depend on COMMON_CLK
Date: Mon, 2 Jul 2018 16:37:58 +0200
Message-ID: <CAPDyKFrZYixkv7Exjt-L18sNX5sVcOLq_uFVxJmUwdU4Q6kavg@mail.gmail.com>
References: <1528310612-10158-1-git-send-email-clabbe@baylibre.com>
 <CAPDyKFoRUhwHk6=j0-scQa4W+nbnS_qXZbPUn0eTFm_3kqdwPQ@mail.gmail.com> <CAMuHMdU709R3woOAvw7EH4=zGiBtezg0YeEer-4wG7pqo2SZBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdU709R3woOAvw7EH4=zGiBtezg0YeEer-4wG7pqo2SZBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Corentin Labbe <clabbe@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2 July 2018 at 15:32, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Mon, Jul 2, 2018 at 3:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 6 June 2018 at 20:43, Corentin Labbe <clabbe@baylibre.com> wrote:
>> > This patch fix the following build failure on m68k:
>> > ERROR: "clk_set_rate" [drivers/mmc/host/dw_mmc.ko] undefined!
>> >
>> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>
>> Thanks, applied for next!
>
> Please drop this patch, I posted proper fixes for this general issue in series
> "[PATCH 0/3] Legacy clock drivers: Normalize clk API"
> (https://lkml.org/lkml/2018/6/11/122).
>
> All fixes above are already in next-20180702.
> Thanks!

Thanks for letting me know, patch dropped!

I had the feeling there was a better way. :-)

[...]

Kind regards
Uffe
