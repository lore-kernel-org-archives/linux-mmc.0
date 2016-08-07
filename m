From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend 0/1] mmc: pwrseq-simple: Add an optional
 post-power-on-delay
Date: Sun,  7 Aug 2016 21:02:37 +0200
Message-ID: <1470596558-23195-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree <devicetree@vger.kernel.org>, linux-mmc@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.xyz>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Ulf, Rob,

Here is a resend of a patch from me from a couple of weeks ago.

There was some discussion about this back then, but if I understood
correctly, the end-conclusion was that Rob was ok with this change
(with the caveat that we should not add 6 more confgurable delays
at other points to the -simple binding later).

Rob have I understood that correctly, if so can we please have your
ack for the dt bits of this ?

Ulf can you review and if ok merge this once we've Rob's ack ?

Thanks & Regards,

Hans
