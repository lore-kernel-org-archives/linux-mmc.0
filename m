From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 1/2] DT: bindings: remove bcm2835-sdhci
Date: Thu, 9 Jun 2016 20:11:50 +0200 (CEST)
Message-ID: <1995060523.43076.c268f06d-da3c-427e-800f-fbc65895c323.open-xchange@email.1und1.de>
References: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
 <1464983233-27001-2-git-send-email-stefan.wahren@i2se.com>
 <5751E1F1.5020202@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5751E1F1.5020202@wwwdotorg.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Lee Jones <lee@kernel.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Stephen,

> Stephen Warren <swarren@wwwdotorg.org> hat am 3. Juni 2016 um 22:00
> geschrieben:
> 
> 
> On 06/03/2016 01:47 PM, Stefan Wahren wrote:
> > The sdhci-iproc also supports bcm2835. So this binding is obsolete.
> 
> sdhci-iproc supports this binding, so I don't believe the binding is 
> obsolete. The duplicate implementations (drivers) can possibly be 
> removed, but not the binding doc, which is (or at least could be) still 
> in use.

sorry for my late reply.

So the brcm,bcm2835-sdhci.txt must be kept, even if the compatible string
"brcm,bcm2835-sdhci" has been added to brcm,sdhci-iproc.txt?

Do i need to send a new version of this series?

Stefan

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
