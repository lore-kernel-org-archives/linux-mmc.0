From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 26/27] mmc: mmci: add DT bindings for STM32 sdmmc
Date: Tue, 25 Sep 2018 10:27:34 -0500
Message-ID: <20180925152734.GA28148@bogus>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-27-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1537523181-14578-27-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, benjamin.gaignard@linaro.org, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 21, 2018 at 11:46:20AM +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> STM32 sdmmc variant has support to:
> -Indicate signal directions (only one property
> for d0dir, d123dir, cmd_dir)
> -Select command and data phase relation.
> -Select "clock in" from an external driver.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
> change v3:
> -remove space at end of "st,use-ckin "
> 
>  Documentation/devicetree/bindings/mmc/mmci.txt | 9 +++++++++

I acked v1. Please add acks when posting new versions.

>  drivers/mmc/host/mmci.c                        | 6 ++++++
>  drivers/mmc/host/mmci.h                        | 1 +
>  3 files changed, 16 insertions(+)
