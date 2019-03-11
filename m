From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v1 1/2] mmc: add SDIO identifiers for MediaTek Bluetooth
 devices
Date: Tue, 12 Mar 2019 05:41:52 +0800
Message-ID: <1552340512.17993.4.camel@mtkswgap22>
References: <cover.1552007058.git.sean.wang@mediatek.com>
         <97d7949c00bd78f8ec282fb9cd380ad161244616.1552007059.git.sean.wang@mediatek.com>
         <7C99941A-306E-4233-9EA4-5D681308C490@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7C99941A-306E-4233-9EA4-5D681308C490@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: ulf.hansson@linaro.org, Johan Hedberg <johan.hedberg@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 2019-03-11 at 17:38 +0100, Marcel Holtmann wrote:
> Hi Sean,
> 
> > The SDIO identifier for MediaTek Bluetooth devices were defined in the
> > MediaTek Bluetooth driver. Moving the definitions in MMC header file
> > seems common sense.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> > include/linux/mmc/sdio_ids.h | 2 ++
> > 1 file changed, 2 insertions(+)
> 
> patch has been applied to bluetooth-next tree.
> 
> Can we also update the sdio.ids database inside systemd.
> 
> https://github.com/systemd/systemd/blob/master/hwdb/sdio.ids
> 


Sure, thanks for showing me the information and I'll update the database
for the card.

> Regards
> 
> Marcel
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
