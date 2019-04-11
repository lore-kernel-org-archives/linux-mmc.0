From: Christoph Hellwig <hch@lst.de>
Subject: get rid of dma_max_pfn
Date: Thu, 11 Apr 2019 09:09:46 +0200
Message-ID: <20190411070948.29564-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi everyone,

I though I got rid of all non-highmem, non-ISA block layer bounce
buffering a while ago, but I missed the MMC case.  While I still plan to
also kill off the highmem bouncing there I won't get to it this merge
window, so for now I'd like to make some progress and move MMC to the
DMA layer (swiotlb or arm dmabounce) bouncing for addressing limitations
and kill off the dma_max_pfn helper.
