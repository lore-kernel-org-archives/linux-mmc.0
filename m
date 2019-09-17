From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
Date: Tue, 17 Sep 2019 10:06:12 +0200
Message-ID: <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr>
References: <20190916171509.GG25745@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190916171509.GG25745@shell.armlinux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 16/09/2019 19:15, Russell King - ARM Linux admin wrote:

> The platform has an iommu, which is in pass-through mode, via
> arm_smmu.disable_bypass=0.

Could be 954a03be033c7cef80ddc232e7cbdb17df735663
"iommu/arm-smmu: Break insecure users by disabling bypass by default"

Although it had already landed in v5.2

Regards.
