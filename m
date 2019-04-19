From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 0/4] Add tracing for SDHCI register access
Date: Fri, 19 Apr 2019 15:08:18 -0400
Message-ID: <20190419150818.1f8ec963@gandalf.local.home>
References: <20190411220822.81845-1-rrangel@chromium.org>
        <7b77ebcb-b42b-2d14-f5f1-b37e07b88469@intel.com>
        <20190412145012.GA101407@google.com>
        <bd3a1df1-5ac4-e23c-35a3-78361a5c356e@intel.com>
        <20190419184013.GA145226@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190419184013.GA145226@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul Rangel <rrangel@chromium.org>
Cc: linux-trace-devel@vger.kernel.org, linux-mmc@vger.kernel.org, djkurtz@chromium.org, zwisler@chromium.org, Ludovic Barre <ludovic.barre@st.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>, Liming Sun <lsun@mellanox.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ingo Molnar <mingo@redhat.com>, Prabu Thangamuthu <Prabu.T@synopsys.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, 19 Apr 2019 12:40:13 -0600
Raul Rangel <rrangel@chromium.org> wrote:

> Steven,
> Since it seems this series won't be accepted upstream, would you still be
> open to accepting patches for trace_print_register? I can work on adding
> support to lib traceevent.

It would require having a user in the kernel code.

If you are going to do something out of tree, simply make a helper
function inside your trace event, and then write a plugin for it if you
want to use it for libtraceevent. It allows for custom plugins.

-- Steve
