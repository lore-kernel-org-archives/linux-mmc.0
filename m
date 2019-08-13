From: "Michael K. Johnson" <johnsonm@danlj.org>
Subject: Re: [PATCH v3 3/2] mmc: host: sdhci-pci: add Genesys Logic GL975x
 support
Date: Tue, 13 Aug 2019 10:41:27 -0400
Message-ID: <20190813144127.GA1926@people.danlj.org>
References: <20190726020754.GA12078@people.danlj.org>
 <62a756ff-6432-fd43-5e90-038eb28045cd@intel.com>
 <20190812225826.GC30758@people.danlj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190812225826.GC30758@people.danlj.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>
List-Id: linux-mmc@vger.kernel.org

On Mon, Aug 12, 2019 at 06:58:26PM -0400, Michael K. Johnson wrote:
> Add support for the GL9750 and GL9755 chipsets.

This patch has a bug introduced in responding to feedback; it invokes
the wrong reset functions.  New v4 patch coming next will fix that,
is based on the first two (unchanged) v3 patches to add pll enable
support and add the GLI PCI identifier.
