From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH v2 0/4] Add trace events for SD registers.
Date: Tue, 16 Apr 2019 12:32:53 -0600
Message-ID: <20190416183257.247902-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc: djkurtz@chromium.org, zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, hongjiefang <hongjiefang@asrmicro.com>, Jennifer Dahm <jennifer.dahm@ni.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Avri Altman <avri.altman@wdc.com>, Simon Horman <horms+renesas@verge.net.au>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

I am not able to make a single event class for all these registers. They
all have different struct sizes and different printf formats.

Thanks for the reviews!

Changes in v2:
- Made trace_sd_scr print out flags.
- Add BUILD_BUG_ON to make sure tracing stays in sync with structs.
- memcpy using sizeof(__entry->raw)

Raul E Rangel (4):
  mmc: core: Add trace event for SD SCR response
  mmc: core: Add trace event for SD SSR response
  mmc: core: Add trace event for SD OCR response
  mmc: core: Add trace event for CSD response

 drivers/mmc/core/mmc.c     |   4 +
 drivers/mmc/core/sd.c      |  10 ++
 drivers/mmc/core/sd_ops.c  |   6 ++
 include/trace/events/mmc.h | 204 +++++++++++++++++++++++++++++++++++++
 4 files changed, 224 insertions(+)

-- 
2.21.0.392.gf8f6787159e-goog
