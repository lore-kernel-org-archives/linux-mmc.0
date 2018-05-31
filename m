From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 3/4] Documentation: sdhci-msm: Add new compatible
 string for SDCC v5
Date: Wed, 30 May 2018 22:52:16 -0500
Message-ID: <20180531035216.GA12320@rob-hp-laptop>
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
 <1527587561-27448-4-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1527587561-27448-4-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On Tue, May 29, 2018 at 03:22:40PM +0530, Vijay Viswanath wrote:
> From: Sayali Lokhande <sayalil@codeaurora.org>
> 
> For SDCC version 5.0.0 and higher, new compatible string
> "qcom,sdhci-msm-v5" is added.
> 
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
