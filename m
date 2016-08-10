From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH resend] mmc: pwrseq-simple: Add an optional
 post-power-on-delay
Date: Wed, 10 Aug 2016 13:58:31 -0500
Message-ID: <20160810185831.GA19639@rob-hp-laptop>
References: <1470596558-23195-1-git-send-email-hdegoede@redhat.com>
 <1470596558-23195-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1470596558-23195-2-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: devicetree <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.xyz>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Sun, Aug 07, 2016 at 09:02:38PM +0200, Hans de Goede wrote:
> Some devices need a while to boot their firmware after providing clks /
> de-asserting resets before they are ready to receive sdio commands.
> 
> This commits adds a post-power-on-delay-ms devicetree property to
> mmc-pwrseq-simple for use with such devices.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++
>  drivers/mmc/core/pwrseq_simple.c                            | 9 +++++++++
>  2 files changed, 11 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
