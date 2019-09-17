From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
Date: Tue, 17 Sep 2019 09:19:31 +0100
Message-ID: <20190917081931.GI25745@shell.armlinux.org.uk>
References: <20190916171509.GG25745@shell.armlinux.org.uk>
 <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 17, 2019 at 10:06:12AM +0200, Marc Gonzalez wrote:
> On 16/09/2019 19:15, Russell King - ARM Linux admin wrote:
> 
> > The platform has an iommu, which is in pass-through mode, via
> > arm_smmu.disable_bypass=0.
> 
> Could be 954a03be033c7cef80ddc232e7cbdb17df735663
> "iommu/arm-smmu: Break insecure users by disabling bypass by default"
> 
> Although it had already landed in v5.2

It is not - and the two lines that you quoted above are sufficient
to negate that as a cause.  (Please read the help for the option that
the commit referrs to.)

In fact, with bypass disabled, the SoC fails due to other masters.
That's already been discussed privately between myself and Will
Deacon.

arm_smmu.disable_bypass=0 re-enables bypass mode irrespective of
the default setting in the Kconfig.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
