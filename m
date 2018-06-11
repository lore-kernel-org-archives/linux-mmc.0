From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH V2 4/4] mmc: host: Register changes for sdcc V5
Date: Mon, 11 Jun 2018 14:25:14 -0700
Message-ID: <CAE=gft4zgJhhug35ApU+4YkHzFQg1nX9-BwOhmoRANc8GUA0+w@mail.gmail.com>
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
 <1527587561-27448-5-git-send-email-vviswana@codeaurora.org> <12fe9a2d-af74-bc84-3b2c-c150e8768b86@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <12fe9a2d-af74-bc84-3b2c-c150e8768b86@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com
Cc: vviswana@codeaurora.org, Ulf Hansson <ulf.hansson@linaro.org>, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, Bjorn Andersson <bjorn.andersson@linaro.org>, riteshh@codeaurora.org, vbadigan@codeaurora.org, Doug Anderson <dianders@google.com>, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 5, 2018 at 11:33 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 29/05/18 12:52, Vijay Viswanath wrote:
> > Add support to use the new compatible string "qcom,sdhci-msm-v5".
> >
> > Based on the msm variant, pick the relevant variant data and
> > use it for register read/write to msm specific registers.
> >
> > Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> > Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
