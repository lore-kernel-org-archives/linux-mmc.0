From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 0/4] Add tracing for SDHCI register access
Date: Fri, 12 Apr 2019 09:26:44 +0300
Message-ID: <7b77ebcb-b42b-2d14-f5f1-b37e07b88469@intel.com>
References: <20190411220822.81845-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411220822.81845-1-rrangel@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>, linux-trace-devel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: djkurtz@chromium.org, zwisler@chromium.org, Ludovic Barre <ludovic.barre@st.com>, Steven Rostedt <rostedt@goodmis.org>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>, Liming Sun <lsun@mellanox.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ingo Molnar <mingo@redhat.com>, Prabu Thangamuthu <Prabu.T@synopsys.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 12/04/19 1:08 AM, Raul E Rangel wrote:
> I was debugging a SDHC hardware bug and got tired of having to
> translate the register values by hand. This patch set makes it so all
> SDHC register read and write operations can be traced and easily read by
> a human.

While this might be useful for people unfamiliar with SDHCI, I am not sure
it should be in the upstream kernel.  Also, it doesn't seem ideal for every
driver to add its own plumbing for such a feature.
