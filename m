From: Jeremy McNicoll <jmcnicol@redhat.com>
Subject: Re: [PATCH v7 02/14] clk: qcom: Move all sdcc rcgs to use
 clk_rcg2_floor_ops
Date: Mon, 14 Nov 2016 16:06:35 -0800
Message-ID: <c17ee2b7-0f4a-c310-f8b8-ec48daf57da0@redhat.com>
References: <1479103248-9491-1-git-send-email-riteshh@codeaurora.org>
 <1479103248-9491-3-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1479103248-9491-3-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 2016-11-13 10:00 PM, Ritesh Harjani wrote:
> From: Rajendra Nayak <rnayak@codeaurora.org>
>
> The sdcc driver for msm8996/msm8916/msm8974 and apq8084
> expects a clk_set_rate() on the sdcc rcg clk to set
> a floor value of supported clk rate closest to the requested
> rate, by looking up the frequency table.
> So move all the sdcc rcgs on all these platforms to use the
> newly introduced clk_rcg2_floor_ops
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  drivers/clk/qcom/gcc-apq8084.c | 8 ++++----
>  drivers/clk/qcom/gcc-msm8916.c | 4 ++--
>  drivers/clk/qcom/gcc-msm8974.c | 8 ++++----
>  drivers/clk/qcom/gcc-msm8996.c | 8 ++++----

Can you please include the same changes for gcc-msm8994.c as it should 
be in sboyd's tree?

If not I will send a patch directly, either way works for me.


-jeremy
