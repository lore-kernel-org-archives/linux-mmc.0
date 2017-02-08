From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2 2/8] mmc: bcm2835: Add new driver for the sdhost
 controller.
Date: Wed, 8 Feb 2017 19:08:26 +0100 (CET)
Message-ID: <2084617651.273763.1486577306244@email.1und1.de>
References: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
 <1486123913-31705-3-git-send-email-kraxel@redhat.com>
 <1708749883.208474.1486413240581@email.1und1.de>
 <1486454575.24589.29.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1486454575.24589.29.camel@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, f.fainelli@gmail.com, sbranden@broadcom.com, swarren@wwwdotorg.org, rjui@broadcom.com, lee@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, eric@anholt.net, robh+dt@kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, catalin.marinas@arm.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


> Gerd Hoffmann <kraxel@redhat.com> hat am 7. Februar 2017 um 09:02 geschrieben:
> ...
> > 
> > I'll send it after my tests. In the following review i will mention only the issues which aren't fixed in my patch series.
> 
> I'll pick up the patches and look at the remaining issues, new version
> later this week (i hope).

No need to hurry. The merge window opens soon.

Do you take care of the missing downstream patch ( bcm2835-sdhost: Only claim one DMA channel ) which affects most of your patch series?

> 
> thanks,
>   Gerd
>
