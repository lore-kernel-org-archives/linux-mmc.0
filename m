From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/4] mmc: omap: adapt the hsmmc driver to device tree
Date: Fri, 4 Nov 2011 23:15:59 +0100
Message-ID: <461DAB8E-1828-44C9-9A0B-D9C09ED9CA0A@kernel.crashing.org>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com>
	<1320407441-29697-3-git-send-email-rnayak@ti.com>
	<20111104200415.GC3045@quad.lixom.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111104200415.GC3045@quad.lixom.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, balajitk@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, linux-mmc@vger.kernel.org, rob.herring@calxeda.com, cjb@laptop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

>> +ti,hsmmc-non-removable: non-removable slot (like eMMC)
>
> Same here, non-removable should be standardized.

CHRP has a "built-in" property for this.  That was standardised in 1998,
you could reuse it :-)


Segher
