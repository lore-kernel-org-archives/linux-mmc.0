From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Add support for vendor capabilities registers
Date: Sat, 21 Mar 2015 15:23:18 -0700
Message-ID: <CAJAp7Ojx19fBaUd3FhSHPy7LjOvnBisOe8jutm_=E1d6j0E85g@mail.gmail.com>
References: <1426949417-5498-1-git-send-email-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426949417-5498-1-git-send-email-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Mar 21, 2015 at 7:50 AM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> Some versions of this controller do not advertise their 3.0v and
> 8bit bus-width support capabilities. It is required to explicitly
> set these capabilities for the specific controller versions.
>
[..]
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
[..]
> +
> +#define CORE_VENDOR_SPEC_CAPABILITIES0 0x11c
> +#define CORE_8_BIT_SUPPORT             BIT(18)
> +#define CORE_3_0V_SUPPORT              BIT(25)

The $11c register is specified to drive the lower capability register
directly, hence you should use the sdhci defines for these bits
instead of duplicating them here; SDHCI_CAN_DO_8BIT and
SDHCI_CAN_VDD_300 that is.

I'm sorry for missing this when looking at v1 :/

Regards,
Bjorn
