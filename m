From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH V2 1/4] mmc: sdhci-msm: Define new Register address map
Date: Mon, 11 Jun 2018 14:14:20 -0700
Message-ID: <CAE=gft5C+TnXEFTnEHYnArXfAY5YKUXfbVheTDoMfWnbaaTdPQ@mail.gmail.com>
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
 <1527587561-27448-2-git-send-email-vviswana@codeaurora.org> <2adfe55e-1c75-046b-594c-aa80b732c68d@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2adfe55e-1c75-046b-594c-aa80b732c68d@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com
Cc: vviswana@codeaurora.org, Ulf Hansson <ulf.hansson@linaro.org>, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, Bjorn Andersson <bjorn.andersson@linaro.org>, riteshh@codeaurora.org, vbadigan@codeaurora.org, Doug Anderson <dianders@google.com>, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 5, 2018 at 11:31 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 29/05/18 12:52, Vijay Viswanath wrote:
> > From: Sayali Lokhande <sayalil@codeaurora.org>
> >
> > For SDCC version 5.0.0, MCI registers are removed from SDCC
> > interface and some registers are moved to HC.
> > Define a new data structure where we can statically define
> > the address offsets for the registers in different SDCC versions.
> >
> > Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> > Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>
> It would be prettier to line up the '=' and use BIT() not << but nevertheless:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
