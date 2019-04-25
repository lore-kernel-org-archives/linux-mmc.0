From: Christoph Hellwig <hch@infradead.org>
Subject: Re: sg_dma_page_iter offset & length considerations
Date: Thu, 25 Apr 2019 01:02:43 -0700
Message-ID: <20190425080243.GA10677@infradead.org>
References: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: jgg@mellanox.com, imre.deak@intel.com, Linux Kernel <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>
List-Id: linux-mmc@vger.kernel.org

Given that mmc uses block layer helpers to build the sg list you
just have to set the right block layer and DMA layer (in case an
iommu merges during map_sg) dma_boundary paramters (PAGE_SIZE - 1),
and you should get sglists formatted to your requirements, no need
to use an iterator.
