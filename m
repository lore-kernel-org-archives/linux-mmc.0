From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: next/master boot: 179 boots: 11 failed,
 167 passed with 1 offline (next-20180731)
Date: Wed, 1 Aug 2018 11:58:58 +0200
Message-ID: <CAPDyKFoJ173XKL-xSRJtvk5_3E2cx1Pb-rs=7g9d9+Gt8QAOqQ@mail.gmail.com>
References: <5b607cc4.1c69fb81.6c1d6.6534@mx.google.com>
 <20180731160623.GH5719@sirena.org.uk>
 <c50e3311-9dca-c64b-ca58-6a44e3559e98@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <c50e3311-9dca-c64b-ca58-6a44e3559e98@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ludovic BARRE <ludovic.barre@st.com>
Cc: kernel-build-reports@lists.linaro.org, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, David Brown <david.brown@linaro.org>, Mark Brown <broonie@kernel.org>, linux-next@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 1 August 2018 at 10:19, Ludovic BARRE <ludovic.barre@st.com> wrote:
> hi Mark, Ulf
>
> When I see log, I think the patch in attachment could fix this issue
> , but like I've not qcom board I can't test if it's fixed :-(.
>
> Ulf: for patch delivery, you prefer a patch delivery on mailing list ?

Thanks for looking into this.

However, no need to post a fix this time (your patch fixed the issue,
but should declare the qcom_variant_init() in mmci.h.

I have already amended the patch, so no further actions is needed.

[...]

Kind regards
Uffe
