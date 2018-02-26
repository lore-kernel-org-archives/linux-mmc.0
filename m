From: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Subject: [PATCH 0/2 v3] mmc: dw_mmc: Fix DTO/STO timeout overflow calculation
Date: Mon, 26 Feb 2018 17:34:11 +0300
Message-ID: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Douglas Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, stable@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

For some 32-bit architectures calculation of DTO and STO timeout can be incorrect
due to multiply overflow. Lets prevent this by casting multiply and result to u64.

Suggested by Jisheng Zhang.
Switch DIV_ROUND_UP macro to DIV_ROUND_UP_ULL is not reasonable
because overflow happens on multiply and DIV_ROUND_UP_ULL helps
with sum overflow.

---
Changes since v2:
-add fix for cto_ms

Evgeniy Didin (2):
  mmc: dw_mmc: Fix the DTO timeout overflow calculation for 32-bit
    systems
  mmc: dw_mmc: Fix the CTO overflow calculation for 32-bit systems

 drivers/mmc/host/dw_mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.11.0
