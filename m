From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Remove D3 delays for Intel BYT-related
 host controllers
Date: Tue, 10 Oct 2017 10:01:35 +0100
Message-ID: <1507626095.26339.5.camel@linux.intel.com>
References: <1507294259-20438-1-git-send-email-adrian.hunter@intel.com>
         <20171006162048.GC25517@bhelgaas-glaptop.roam.corp.google.com>
         <ada41e9b-6fb3-82ab-e458-af4942adba2d@intel.com>
         <20171009134154.GJ25517@bhelgaas-glaptop.roam.corp.google.com>
         <363DA0ED52042842948283D2FC38E4649BF3590E@IRSMSX106.ger.corp.intel.com>
         <20171009202502.GN25517@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20171009202502.GN25517@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-mmc@vger.kernel.org

> Your concern was that a quirk would require a long list of device IDs
> and we'd have to add new ones.  I share that concern,

I'm not sure I do. The bus topology tells you what is on die, and the
id of the root bridge tells you if it's one of the parts you can do
this.

Alan
