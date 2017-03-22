From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [v5 1/4] mmc: sdhci-cadence: Fix writing PHY delay
Date: Wed, 22 Mar 2017 16:24:48 +0900
Message-ID: <CAK7LNAQWPDfhi5kSikOJC_+KSFYnencmNTqUv_taQN-DY9FW1g@mail.gmail.com>
References: <1490106736-2242-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490106736-2242-1-git-send-email-piotrs@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

2017-03-21 23:32 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> Add polling for ACK to be sure that data are written to PHY register.
>
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>


Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
