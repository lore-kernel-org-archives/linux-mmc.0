From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v7 1/5] mmc: davinci: allow driver to work without DMA
 resource
Date: Tue, 2 Apr 2013 14:09:29 +0530
Message-ID: <515A9941.9030708@ti.com>
References: <1364476211-14322-1-git-send-email-prakash.pm@ti.com> <1364476211-14322-2-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1364476211-14322-2-git-send-email-prakash.pm@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-mmc@vger.kernel.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, arnd@arndb.de
List-Id: linux-mmc@vger.kernel.org

On 3/28/2013 6:40 PM, Manjunathappa, Prakash wrote:
> Do not return probe failure with missing DMA resources,
> allow driver to work in PIO mode.
> Tested on da850-evm by mounting partition followed by
> file creation and deletion.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> Tested-by: Sekhar Nori <nsekhar@ti.com>

Chris accepted this patch on March 22nd. You should have dropped this
from this series.

Thanks,
Sekhar
