From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] mmc: mmci: Support odd block sizes for ux500v2 and
 qcom variant
Date: Wed, 13 Nov 2019 14:17:40 +0100
Message-ID: <CACRpkdZhMjWyWQav1HhmfDkvUxOU8gGGbYJrd-tRXw8u+d2-Rg@mail.gmail.com>
References: <20191113075335.31775-1-linus.walleij@linaro.org>
 <20191113075335.31775-2-linus.walleij@linaro.org>
 <CAPDyKFqx-0J0ck-hyeJsX8LrOP+BWiS6PihLd1Y3EMoXX+qYiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFqx-0J0ck-hyeJsX8LrOP+BWiS6PihLd1Y3EMoXX+qYiQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Stephan Gerhold <stephan@gerhold.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Niklas Cassel <niklas.cassel@linaro.org>, Ludovic Barre <ludovic.barre@st.com>, Brian Masney <masneyb@onstation.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 13, 2019 at 12:06 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> > From: Ulf Hansson <ulf.hansson@linaro.org>
(...)
> There is no need to keep my authorship of the patch, it's very much
> different than the original. I would rather replace it that with a
> suggested-by tag.

OK

> This is too early in the series. You need to deal with the DMA and pio
> issues, before releasing this constraint.
>
> In other words, I would rather split this patch in two pieces. One
> patch dealing with dma submit error path, placed first in the series
> and another patch that adds the odd block sizes variant and releases
> the constraint, which should comes last.
>
> Makes sense?

Sure thing, I fix. We need to get the whole slew tested first then
I'll collect the Tested-by's and reorder and split.

Yours,
Linus Walleij
