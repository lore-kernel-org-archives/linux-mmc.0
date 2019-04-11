From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH v1 0/4] Add tracing for SDHCI register access
Date: Thu, 11 Apr 2019 16:08:18 -0600
Message-ID: <20190411220822.81845-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-trace-devel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: djkurtz@chromium.org, zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>, Ludovic Barre <ludovic.barre@st.com>, Steven Rostedt <rostedt@goodmis.org>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Adrian Hunter <adrian.hunter@intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>, Liming Sun <lsun@mellanox.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ingo Molnar <mingo@redhat.com>, Prabu Thangamuthu <Prabu.T@synopsys.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

I was debugging a SDHC hardware bug and got tired of having to
translate the register values by hand. This patch set makes it so all
SDHC register read and write operations can be traced and easily read by
a human.

An example trace can be seen here: https://pastebin.com/x73d5cvL

I ended up defining a new tracing function `trace_print_register`. This
method takes a register definition and pretty prints it. It's a hybrid
of `trace_print_flags_seq` and `trace_print_symbols_seq`. It supports
printing bit fields, enum fields, and numeric fields. See the
documentation for usage.

I hope this makes someone else's life easier when debugging SDHC
hardware problems.

Raul E Rangel (4):
  trace_events: Add trace_print_register to print register fields
  mmc/sdhci: Rename sdhci.c to sdhci-core.c
  mmc/host/sdhci: Add register read and write trace events
  mmc/host/sdhci: Make sdhci_read/sdhci_write call trace functions

 drivers/mmc/host/Makefile                  |   4 +
 drivers/mmc/host/{sdhci.c => sdhci-core.c} | 136 +++++++++
 drivers/mmc/host/sdhci-trace.c             | 319 +++++++++++++++++++++
 drivers/mmc/host/sdhci-trace.h             |  93 ++++++
 drivers/mmc/host/sdhci.h                   |  89 +-----
 include/linux/trace_events.h               |   4 +
 include/linux/tracepoint-defs.h            |   6 +
 include/trace/trace_events.h               |   9 +
 kernel/trace/trace_output.c                | 121 ++++++++
 9 files changed, 698 insertions(+), 83 deletions(-)
 rename drivers/mmc/host/{sdhci.c => sdhci-core.c} (97%)
 create mode 100644 drivers/mmc/host/sdhci-trace.c
 create mode 100644 drivers/mmc/host/sdhci-trace.h

-- 
2.21.0.392.gf8f6787159e-goog
