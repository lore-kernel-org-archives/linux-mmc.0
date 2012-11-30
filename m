From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: omap_hsmmc: SDIO IRQ on AM335x family
Date: Fri, 30 Nov 2012 12:18:47 +0100
Message-ID: <20121130111847.GA24674@blumentopf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Tony Lindgren <tony@atomide.com>, Daniel Mack <daniel@zonque.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

I submitted following patches a while back,
http://www.spinics.net/lists/linux-mmc/msg17624.html. Since
there was no feedback I'm taking a step back, documenting:

1. why is it needed, missing swakeup line
2. transition, enable workaround by default
3. device tree configuration


[why is it needed, problem outline]

The omap_hsmmc module is suspended whenever it is idle, its
functional clock being turned off. In this mode it is not able to
forwared IRQs to the system. For that to happen, it needs to tell
the PRCM to restore it's fclk.

                   ------
                  | PRCM |
                   ------
                    | ^
               fclk | | swakeup
                    v |
                  -------               ------
      <-- IRQ -- | hsmmc | <-- CIRQ -- | card |
                  -------               ------

This is done through the swakeup line, which can be configured to
trigger for various events, among others; CIRQ. The problem is
that on the AM335x family the swakeup line is missing, it has not
been routed from the module to the PRCM.

https://www.google.com/search?q=spruh73c
see 18.2 compare with 20.2.2, or just search the whole doc for
swakeup

One solution is to keep the fclk enabled while waiting
for CIRQ. This is the approach taken by existing patches:

http://www.spinics.net/lists/linux-omap/msg63363.html
http://marc.info/?l=linux-mmc&m=126580279403824&w=2
http://thread.gmane.org/gmane.linux.kernel.mmc/1107/focus=1109

authors, contributors
David Vrabel (based my work on it)
John Rigby

The alternative was to configure dat1 line as a GPIO, while
waiting for an IRQ. Then configuring it back as dat1 when the
SDIO card is signalling an IRQ. Or the host starts a transfer. I
guess this will perform poorly, hence not considering it really.

[transition, enable workaround by default?]

Up to now the driver uses polling, which works for all SOCs.
Once we enable the IRQ, all chips missing an swakeup will fail.
But I don't know all of them, so how to transition without
breaking existing platforms?

Enable IRQ only for AM335x, use polling for others?
Keep clock running for all, only disable workaround for known
good platforms?

[device tree configuration]

My previous patch, see link at top, uses a new property
'ti,swakeup-not-implemented'. Then in the DT files I enabled the
workaround for my platform.

Now I learned that I should rather use a new 'compatible'
section. Actually Daniel talked me out of it:
'Since this feature should always be enabled on one given
processor, the IP block is actually "compatible" to something
else than a processor that doesn't support that feature. So the
"compatible" line alone should be enough of an information for
the one who provides the DT. On the other hand, if enabling a
certain option depends on the system design of an application, it
deserves a special binding in DT.'

I'd prefer the latter now.


Thanks for your attention,
/Andi

