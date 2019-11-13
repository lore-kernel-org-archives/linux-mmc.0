From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/3] mmc: mmci: Proper PIO residue handling
Date: Wed, 13 Nov 2019 14:24:27 +0100
Message-ID: <CACRpkdZLiy4BSh1JYtQj0HjKk3=qdyKoj9tQv4HrthDi=4e-Bg@mail.gmail.com>
References: <20191113075335.31775-1-linus.walleij@linaro.org>
 <20191113075335.31775-4-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191113075335.31775-4-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Stephan Gerhold <stephan@gerhold.net>
Cc: Niklas Cassel <niklas.cassel@linaro.org>, Russell King <rmk+kernel@armlinux.org.uk>, Russell King <linux@arm.linux.org.uk>, Ludovic Barre <ludovic.barre@st.com>, Brian Masney <masneyb@onstation.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 13, 2019 at 8:53 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> +               /* Pack the residue into a 32bit word */
> +               for (i = 0; i < host->pio_write_residue_sz; i++) {
> +                       val |= host->pio_write_residue[i];
> +                       val <<= 8;
> +               }
> +               /* Top up with new data */
> +               for (i = 0; i < fill; i++) {
> +                       val |= *ptr;
> +                       val <<= 8;
> +                       ptr++;
> +                       remain--;
> +               }

I'm worried that I might have gotten this wrong.

iowrite32_rep() reads the data little-endian (native endianness)
from memory does it not?

Bytes  [0 1 2 3] end up in the FIFO like [3 2 1 0].

So it will pack the first byte into the lowest 8 bits, second byte into
bits 8-15 etc.

So I should rewrite all the loops like this:

for (i = 0; i < host->pio_write_residue_sz; i++) {
        val |= (host->pio_write_residue[i] << 24);
        val >>= 8;
}

So I shift the value down from the high bits instead of the
other way around.

This also gives a pretty plausible hint att what might be wrong with the
DMA in non-divisible by 4.

As suggested by Stephan in another context, I will try to set up my
own test rig for this.

Yours,
Linus Walleij
