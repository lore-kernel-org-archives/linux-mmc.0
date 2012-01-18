From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/7] extract a simple dmaengine library from
	shdma.c
Date: Wed, 18 Jan 2012 11:22:14 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201181025280.28782@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, "Shimoda,
	Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>, linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This patch series has been triggered by a recent series by Shimoda-san
http://www.spinics.net/lists/linux-sh/index.html#09895
In a follow up to that thread it has been decided to extract a common 
library from the current shdma driver to be re-used by other dmaengine 
drivers. Primarily this library provides a flexible transfer descriptor 
management for hardware, that does not dupport scatter-gather lists 
natively. In such cases this library can be used to split transfer 
requests into smaller chunks, up to the size, supported by the specific 
hardware, enter them onto a linked list, thack their completion and call 
user callbacks. This is a first shot, aimed to be used by the SUDMAC 
driver. Once it is confirmed, that this version can be conveniently used 
with it, I'll do some cosmetic clean up, notably, add / improve 
documentation:-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
