From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH V5 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically
Date: Mon, 19 Nov 2018 10:50:43 -0800
Message-ID: <CAE=gft7EFFEawCe02KOkB9T_fMPBfQTXEk-cddEQdDnVOQ+Yyg@mail.gmail.com>
References: <1542005537-19154-1-git-send-email-vbadigan@codeaurora.org> <1542005537-19154-3-git-send-email-vbadigan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542005537-19154-3-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vbadigan@codeaurora.org
Cc: adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>, robh+dt@kernel.org, Doug Anderson <dianders@google.com>, asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayali <sayalil@codeaurora.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sun, Nov 11, 2018 at 10:53 PM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> On few SDHCI-MSM controllers, the host controller's clock tuning
> circuit may go out of sync if controller clocks are gated which
> eventually will result in data CRC, command CRC/timeout errors.
> To overcome this h/w limitation, the DLL needs to be re-initialized
> and restored with its old settings once clocks are ungated.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
