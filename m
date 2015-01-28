From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 2/2] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
Date: Wed, 28 Jan 2015 13:46:27 +0100
Message-ID: <2323575.nqxsEzcHbG@wuerfel>
References: <1422379260-10139-1-git-send-email-stripathi@apm.com>
 <CAOHikRB4tSkJsMccqHRS8XYULaP+dS7KujeSLh+ZpTxDDOF5xQ@mail.gmail.com>
 <CAOHikRAOVMQiOy_VrXmJU1e+8KBwOFSfX1uSKvfdbVG=Br2ocg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOHikRAOVMQiOy_VrXmJU1e+8KBwOFSfX1uSKvfdbVG=Br2ocg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Tripathi <stripathi@apm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>, anton@enomsg.org, linux-mmc@vger.kernel.org, chris@printf.net, patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday 28 January 2015 09:53:25 Suman Tripathi wrote:
> 
> I added the iommus in the IOMMU AHBC patch. Anything wrong in that ?
> In the next version Also I will remove the IOMMU hacks from arasan
> driver

Hmm, I guess you have a required ordering between the patches either
way, which makes it hard to merge in a way that is bisectable.

You are correct that you should not merge a patch with the iommu
reference before adding the iommu device node, because it would
otherwise break building the mmc tree.

Usually, the right answer is to merged the dts changes through the
arm-soc tree, and then you can just add the node for the sdhc device
after the one for the iommu device.

	Arnd
