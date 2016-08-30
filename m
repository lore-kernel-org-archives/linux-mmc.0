From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt: bindings: Add binding for ESP8089 wifi chips
Date: Tue, 30 Aug 2016 16:59:58 -0500
Message-ID: <20160830215958.GA17243@rob-hp-laptop>
References: <1470936385-4621-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1470936385-4621-1-git-send-email-hdegoede@redhat.com>
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

On Thu, Aug 11, 2016 at 07:26:25PM +0200, Hans de Goede wrote:
> The ESP8089 chips can mostly be enumerated via their sdio interface,
> but they are clocked by an external crystal which may differ from one
> board to the other.
> 
> This commit adds a binding for the sdio child node for these chips,
> allowing to specify the external crystal type (for now, this binding
> could be be extended with e.g. OOB irq support later).
> 
> The Android driver for this chip uses a text file with key,value pairs
> which gets loaded as firmware to pass this info to the firmware.
> The "esp,crystal_26M_en" name is chosen to match the crystal_26M_en
> key-name in that text file.
> 
> Note that at this point there only is an out of tree driver for this
> hardware, there is no clear timeline / path for merging this. Still
> I believe it would be good to specify the binding for this in tree
> now, so that any future migration to an in tree driver will not cause
> compatiblity issues.
> 
> Cc: Icenowy Zheng <icenowy@aosc.xyz>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Use esp,crystal-26M-en instead of esp,crystal_26M_en
> ---
>  .../bindings/net/wireless/esp,esp8089.txt          | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/esp,esp8089.txt

Applied, thanks.

Rob
