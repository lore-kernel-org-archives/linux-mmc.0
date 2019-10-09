From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V7 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
Date: Wed, 9 Oct 2019 11:12:14 +0200
Message-ID: <CAPDyKFrKrV3e6WmrgzUA0OV4VGm0BMXr0=orogAhHQM3nRpxqQ@mail.gmail.com>
References: <20191008095604.20675-1-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191008095604.20675-1-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Tue, 8 Oct 2019 at 11:56, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch series adds busy detect for stm32 sdmmc variant.
> Some adaptations are required:
> -On sdmmc the data timer is started on data transfert
> and busy state, so we must add hardware busy timeout support.
> -Add busy_complete callback at mmci_host_ops to allow to define
> a specific busy completion by variant.
> -Add sdmmc busy_complete callback.
>
> V7:
> -Patch 1/3: rephrasing like proposed (thx ulf)
> -If busy timeout is undefined => increase to 10s
> -Keep busy_detect.
> -Patch 3/3: rephrasing comment header
> -Avoid twice read of status register
> -Avoid writing in MMCIMASK0 & MMCICLEAR if not modified
>

Applied for next, thanks!

[...]

Kind regards
Uffe
