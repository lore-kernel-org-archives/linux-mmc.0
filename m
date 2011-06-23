From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/4] PCI: make cardbus-bridge resources nice-to-have
Date: Thu, 23 Jun 2011 22:42:29 +0200
Message-ID: <201106232242.29753.rjw@sisk.pl>
References: <1308610037-6261-1-git-send-email-linuxram@us.ibm.com> <20110622004816.GC22917@ram-laptop> <20110623133137.03c74ea4@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20110623133137.03c74ea4@jbarnes-desktop>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, svenkatr@ti.com, yinghai@kernel.org, cjb@laptop.org, linux-pci@vger.kernel.org, linux-net-drivers@solarflare.com, bhutchings@solarflare.com, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-mmc@vger.kernel.org

On Thursday, June 23, 2011, Jesse Barnes wrote:
> On Tue, 21 Jun 2011 17:48:16 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> > I assume majority of the platforms will have enough resources to satisfy all
> > the resource requests, and their BIOS would have done a decent job.
> > 
> > Even if the BIOS has not done a decent job, and there are enough resources
> > available we should not see a regression.
> > 
> > The only platforms that would expose a regression is when resources are under
> > contention and the BIOS has assigned enough resource to the cardbus bridge but
> > not to some other device. It will be hard to find such a platform, but I am
> > sure there is one out somewhere there.
> > 
> > I am sure we will see; some day, reports of regression because that platform
> > would have the exact right characteristics to expose the issue. But then that
> > platform is a highly constrained platform in the first place. Its debatable if
> > that should be characterised as a regression, or a platform that was riding on
> > good luck till now.
> > 
> > Even Oliver's platform is a highly constrained platform, and we probably can
> > treat his platform as 'riding on good luck till now'.
> > 
> > We won't be able to satisfy all the platforms with resource constraints.  I
> > think our probable choice is to select a solution that breaks least number of
> > platforms and special case those broken platforms through kernel command line
> > parameters.
> 
> Another option is to hide the new allocation behavior behind a kernel
> parameter.  I know Bjorn has opposed this in the past because really
> this sort of thing should "just work".  But so far it hasn't, and we've
> had to revert both Bjorn's resource tracking changes as well as the
> re-allocation code.
> 
> Hiding it behind a boot option would at least let us improve things
> over time and potentially switch over to new resource code in the
> future...
> 
> Thoughts?

Do I understand correctly that at the moment we have two set of systems,
one of which works with the new code and doesn't work with the old code
and the other one conversely?

Rafael
